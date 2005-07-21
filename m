From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Workqueue freezer support.
Date: Thu, 21 Jul 2005 17:42:34 +0200
Message-ID: <20050721154234.GA1055@elte.hu>
References: <1121923059.2936.224.camel@localhost>
	<20050721153824.GB1896@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============97391955426800569=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050721153824.GB1896@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============97391955426800569==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Pavel Machek <pavel@ucw.cz> wrote:

> > +struct task_struct *kthread_create(int (*threadfn)(void *data),
> > +				   void *data,
> > +				   const char namefmt[], ...)
> > +{
> > +	char result[TASK_COMM_LEN];
> > +
> > +	va_list args;
> > +	va_start(args, namefmt);
> > +	vsnprintf(result, TASK_COMM_LEN, namefmt, args);
> > +	va_end(args);
> > +	return _kthread_create(threadfn, data, 0, result);
> > +}
> > +
> 
> This is slightly ugly and uses lot of stack. Otherwise patch looks 
> okay. If you want me to apply it, be sure to put me into To: or at 
> least Cc:. Or perhaps you want to just mail it to akpm, noting that I 
> acked it (if you do something with the char result[] :-).

TASK_COMM_LEN is only 16 bytes so it's not that bad.

	Ingo

--===============97391955426800569==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============97391955426800569==--
