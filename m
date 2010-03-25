From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 07/15] PM / Hibernate: add sws_modules_ops
Date: Thu, 25 Mar 2010 23:02:53 +0100
Message-ID: <201003252302.53673.rjw__2164.03366434879$1269554790$gmane$org@sisk.pl>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<1269361063-3341-7-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1269361063-3341-7-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, jirislaby@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 23 March 2010, Jiri Slaby wrote:
> For now they will only hold swap operations. In next patches, user
> support will be converted to ops as well to have a single layer and
> can push pages instead of pulling them.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Nigel Cunningham <ncunningham@crca.org.au>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> ---
>  kernel/power/hibernate.c |    2 +
>  kernel/power/power.h     |   13 +++++++++++
>  kernel/power/swap.c      |   51 ++++++++++++++++++++++++++++++---------------
>  3 files changed, 49 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index da5288e..762431e 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -34,6 +34,8 @@ dev_t swsusp_resume_device;
>  sector_t swsusp_resume_block;
>  int in_suspend __nosavedata = 0;
>  
> +struct sws_module_ops *sws_io_ops;
> +
>  enum {
>  	HIBERNATION_INVALID,
>  	HIBERNATION_PLATFORM,
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 6c4b4fa..0f08de4 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -115,6 +115,17 @@ struct snapshot_handle {
>   */
>  #define data_of(handle)	((handle).buffer)
>  
> +struct sws_module_ops {

I'd call that hibernate_io_ops FWIW.

> +	unsigned long (*storage_available)(void);

free_space() ?

> +
> +	int (*get_reader)(unsigned int *flags_p);
> +	int (*put_reader)(void);
> +	int (*get_writer)(void);
> +	int (*put_writer)(unsigned int flags, int error);

I agree with Pavel that these names are not exactly self-documenting.

Would it make sense to use names like reader_start(), reader_finish() and
similarly for "writer"?

> +	int (*read_page)(void *addr, struct bio **bio_chain);
> +	int (*write_page)(void *addr, struct bio **bio_chain);

Also one might think of adding a data pointer to this structure that will
be passed to the callbacks.  This way it would be easier to think of our
storage spaces as objects, each with a set of methods and a pointer to
the data they operate on.

Rafael
