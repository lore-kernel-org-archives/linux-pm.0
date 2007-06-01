From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.22-rc3 hibernate(?) disables skge wol
Date: Fri, 1 Jun 2007 23:42:45 +0200
Message-ID: <200706012342.45657.rjw@sisk.pl>
References: <46608E3F.4060201@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762306AbXFAVg7@vger.kernel.org>
In-Reply-To: <46608E3F.4060201@dgreaves.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: David Greaves <david@dgreaves.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 1 June 2007 23:23, David Greaves wrote:
> Not a regression though, it does it in 2.6.21
> 
> If I cause the system to save state to disk then whilst off it no longer
> responds to g-wol.

Can you please try with the hibernation and suspend patch series from

http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc3/patches/

applied?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
