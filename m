From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: do not stop/start devices in suspend/resume path:
	the SCSI case
Date: Sun, 23 Dec 2007 20:21:35 -0700
Message-ID: <200712232021.36835.bjorn.helgaas__11495.8907281563$1198466708$gmane$org@hp.com>
References: <4745F77C.7040402@gmail.com>
	<200712051124.18852.bjorn.helgaas@hp.com>
	<476F0ED5.3090609@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <476F0ED5.3090609@free.fr>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Stephane Ascoet <stephaneascoet@free.fr>
Cc: Jiri Slaby <jirislaby@gmail.com>, matthew@wil.cx, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, drzeus@drzeus.cx, Matthieu Castet <castet.matthieu@free.fr>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 23 December 2007 6:43:49 pm Stephane Ascoet wrote:
> Bjorn Helgaas a =E9crit :
> > Good.  It's not clear to me whether it is safe to leave devices
> > enabled while we sleep.  I don't see an actual problem, but there
> > might be something related to hotplug while we're asleep or something.
> > So I'll cc: some additional people who might have some insight.
>
> Hi, is there a chance for SCSI sleeping being managed by ACPI(it seems
> to be the case for IDE)?

I'm sorry, I don't know the answer to this.

Bjorn
