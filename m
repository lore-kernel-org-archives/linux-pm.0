From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH] Workqueue freezer support.
Date: Fri, 5 Aug 2005 22:06:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.50.0508052148280.19501-100000@monsoon.he.net>
References: <1121923059.2936.224.camel@localhost>
	<Pine.LNX.4.50.0507211221550.12779-100000@monsoon.he.net>
	<1123243967.3266.2.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============58495856750096298=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1123243967.3266.2.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============58495856750096298==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Fri, 5 Aug 2005, Nigel Cunningham wrote:

> Hi.
>
> I finally found some time to finish this off. I don't really like the
> end result - the macros looked clearer to me - but here goes. If it
> looks okay, I'll seek sign offs from each of the affected driver
> maintainers and from Ingo. Anyone else?

What are your feelings about this: http://lwn.net/Articles/145417/ ?

It seems like a cleaner way to do things. How would these patches change
if that were merged?

Concerning the patch specifically:

> diff -ruNp 400-workthreads.patch-old/include/linux/kthread.h 400-workthreads.patch-new/include/linux/kthread.h
> --- 400-workthreads.patch-old/include/linux/kthread.h	2004-11-03 21:51:12.000000000 +1100
> +++ 400-workthreads.patch-new/include/linux/kthread.h	2005-08-03 11:52:01.000000000 +1000
> @@ -23,10 +23,20 @@
>   *
>   * Returns a task_struct or ERR_PTR(-ENOMEM).
>   */
> +struct task_struct *__kthread_create(int (*threadfn)(void *data),
> +				   void *data,
> +				   unsigned long freezer_flags,
> +				   const char namefmt[],
> +				   va_list * args);
> +

When comparing this to this:

> diff -ruNp 400-workthreads.patch-old/include/linux/workqueue.h 400-workthreads.patch-new/include/linux/workqueue.h
> --- 400-workthreads.patch-old/include/linux/workqueue.h	2005-06-20 11:47:30.000000000 +1000
> +++ 400-workthreads.patch-new/include/linux/workqueue.h	2005-08-03 11:49:34.000000000 +1000
> @@ -51,9 +51,12 @@ struct work_struct {
>  	} while (0)
>
>  extern struct workqueue_struct *__create_workqueue(const char *name,
> -						    int singlethread);
> -#define create_workqueue(name) __create_workqueue((name), 0)
> -#define create_singlethread_workqueue(name) __create_workqueue((name), 1)
> +						    int singlethread,
> +						    unsigned long freezer_flag);
> +#define create_workqueue(name) __create_workqueue((name), 0, 0)
> +#define create_nofreeze_workqueue(name) __create_workqueue((name), 0, PF_NOFREEZE)
> +#define create_singlethread_workqueue(name) __create_workqueue((name), 1, 0)
> +#define create_nofreeze_singlethread_workqueue(name) __create_workqueue((name), 1, PF_NOFREEZE)

And to this:


>  static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
> -						   int cpu)
> +						   int cpu,
> +						   unsigned long freezer_flags)
>  {

There is a slight discrepancy in the API changes. Obviously, we don't want
to change every caller of create_workqueue() to support this. But, perhaps
you could standardize the handling of the freezer flags (by e.g. creating
a separate _nofreeze version for each).

Also, functions that take a va_list parameter pass the structure (array)
rather than the pointer. See the definition of vprintk() in
include/linux/kernel.h for an example.


Thanks,


	Pat

--===============58495856750096298==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============58495856750096298==--
