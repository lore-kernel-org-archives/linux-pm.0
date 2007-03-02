From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2 -stable] libata: add missing PM callbacks
Date: Fri, 2 Mar 2007 23:42:27 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0703022334550.6467@poirot.grange>
References: <20061122172841.0b90f042@localhost.localdomain>
 <Pine.LNX.4.60.0702262150460.5079@poirot.grange> <Pine.LNX.4.60.0702282201250.8832@poirot.grange>
 <Pine.LNX.4.60.0703012305030.7351@poirot.grange> <20070302084530.GN20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20070302084530.GN20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-pm@lists.osdl.org, linux-ide@vger.kernel.org, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2 Mar 2007, Tejun Heo wrote:

> Some LLDs were missing scsi device PM callbacks while having host/port
> suspend support.  Add missing ones.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This should fix the problem you're seeing on sil680.  These patches
> are against 2.6.20.1.  Patches for libata-dev#upstream is separately
> posted to linux-ide in the following thread.

Yep, this looks good now, I think, thanks! I still have to fix some 
badness, but it looks unrelated. The disk switches off and on now 
automatically as expected. I'll do further tests, but, it looks quite good 
as it stands.

Thanks
Guennadi
---
Guennadi Liakhovetski
