From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: memcpy() in swsusp (was: Re: [PATCH 2/2] Fix console
	handling during suspend/resume)
Date: Thu, 6 Jul 2006 15:22:32 +0200
Message-ID: <200607061522.32674.rjw@sisk.pl>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200607061152.08755.ncunningham@linuxmail.org>
	<200607061715.38499.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607061715.38499.ncunningham@linuxmail.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thursday 06 July 2006 09:15, Nigel Cunningham wrote:
> On Thursday 06 July 2006 11:52, Nigel Cunningham wrote:
> > On Thursday 06 July 2006 11:15, Pavel Machek wrote:
> > > I have seen that before: Atomic snapshot used fpu copy in some wrong
> > > variants. Symptom was exactly that -- elevated preempt count --
> > > because fpu copy routine elevated it, then copied the task struct.
> > >
> > > But I thought we solved that problem...?
> >
> > We did. We don't use memcpy for precisely that reason. 3DNOW memcpy was=
 one
> > of the problem children. This would be a different creature though,
> > wouldn't it?
> =

> Hmm. Aparently we had a parting of ways on this at some point. Memcpy is =
being =

> used by swsusp, and it has been used since before 2.6.12-rc1. (This is wh=
en =

> doing the atomic copy, not resuming).

Do you mean the one in copy_data_pages()?  Indeed, that may be a problem if
the MMU-based memcpy is used.

Pavel, should we fix this?

Rafael
