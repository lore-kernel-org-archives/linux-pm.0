From: Stephane Ascoet <stephaneascoet@free.fr>
Subject: Re: do not stop/start devices in suspend/resume path:
	the SCSI case
Date: Mon, 24 Dec 2007 02:43:49 +0100
Message-ID: <476F0ED5.3090609__26255.7679474869$1198781927$gmane$org@free.fr>
References: <4745F77C.7040402@gmail.com> <47511751.2010707@gmail.com>
	<47514CE2.3000600@gmail.com>
	<200712051124.18852.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712051124.18852.bjorn.helgaas@hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, matthew@wil.cx, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, drzeus@drzeus.cx, Matthieu Castet <castet.matthieu@free.fr>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Bjorn Helgaas a =E9crit :
> Good.  It's not clear to me whether it is safe to leave devices
> enabled while we sleep.  I don't see an actual problem, but there
> might be something related to hotplug while we're asleep or something.
> So I'll cc: some additional people who might have some insight.
Hi, is there a chance for SCSI sleeping being managed by ACPI(it seems=20
to be the case for IDE)?

--=20
Bien cordialement, Stephane Ascoet, conseils pour que la technologie=20
soit un progres respectueux de la vie.
Album photo:<http://www.flickr.com/photos/stephaneascoet/>
