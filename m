From: Dave Jones <davej@redhat.com>
Subject: Re: swsusp status report
Date: Tue, 25 Jul 2006 11:11:45 -0400
Message-ID: <20060725151145.GG14964@redhat.com>
References: <200607251325.14747.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932411AbWGYPMc@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200607251325.14747.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 25, 2006 at 01:25:14PM +0200, Rafael J. Wysocki wrote:

 > V. Freeing memory
 > 
 > Step (3) of the suspend procedure is completed by calling the same
 > functions that are normally used by kswapd, but in a slightly different way.
 > The part of swsusp responsible for that is referred to as 'the memory
 > shrinker' and it may sometimes be called by the suspend-to-RAM code as well

This isn't actually necessary though is it ?
(Ie, it's a bug that needs fixing?)

Good write-up btw, it may even be a nice addition to Documentation/power/  ?

		Dave

-- 
http://www.codemonkey.org.uk
