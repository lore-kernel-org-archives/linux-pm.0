From: Lee Revell <rlrevell@joe-job.com>
Subject: software mixing [was Re: [linux-pm] [RFC] userland swsusp]
Date: Thu, 17 Nov 2005 15:50:10 -0500
Message-ID: <1132260611.5959.11.camel@mindpipe>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	 <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost>
	 <20051116220500.GF12505@elf.ucw.cz>
	 <20051117170202.GB10402@dspnet.fr.eu.org>
	 <1132257432.4438.8.camel@mindpipe>
	 <20051117201204.GA32376@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964861AbVKQUuU@vger.kernel.org>
In-Reply-To: <20051117201204.GA32376@dspnet.fr.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Olivier Galibert <galibert@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2005-11-17 at 21:12 +0100, Olivier Galibert wrote:
> 1- It doesn't work without an annoyingly complex, extremely badly
>    documented user configuration. To the point that it doesn't work in
>    either an out-of-the-box, updated Fedora Core 3 nor an
>    out-of-the-box gentoo. 

It's badly documented and complex because .asoundrc was never intended
to be user visible.  If the end user ever needs to edit their ALSA
config files for a standard setup there's a bug somewhere.

Anyway please provide the details of your sound hardware and ALSA driver
& alsa-lib version so we can determine why software mixing does not work
for you.

Lee
