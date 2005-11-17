From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Thu, 17 Nov 2005 15:54:11 -0500
Message-ID: <1132260851.5959.15.camel@mindpipe>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	 <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost>
	 <20051116220500.GF12505@elf.ucw.cz>
	 <20051117170202.GB10402@dspnet.fr.eu.org>
	 <1132257432.4438.8.camel@mindpipe>
	 <20051117201204.GA32376@dspnet.fr.eu.org>
	 <1132258855.4438.11.camel@mindpipe>  <20051117203731.GG5772@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964847AbVKQUyU@vger.kernel.org>
In-Reply-To: <20051117203731.GG5772@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Olivier Galibert <galibert@pobox.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2005-11-17 at 15:37 -0500, Dave Jones wrote:
> (Although every release we seem to trade one set of
>  working sound drivers for a new set of broken ones). 

Because the ALSA project does not have access to the wide variety of
hardware required to regression test every sound driver change.  People
like Red Hat and OSDL do, but they don't help.  I always figured that
this was because those entities consider audio support a low priority.

Lee
