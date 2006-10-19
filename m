From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Block on access to temporarily unavailable pci device
	[version 3]
Date: Thu, 19 Oct 2006 17:32:09 +0100
Message-ID: <1161275529.17335.89.camel@localhost.localdomain>
References: <20061017145146.GJ22289@parisc-linux.org>
	 <20061019154128.GD2602@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946203AbWJSQcs@vger.kernel.org>
In-Reply-To: <20061019154128.GD2602@parisc-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>, Adam Belay <abelay@MIT.EDU>
List-Id: linux-pm@vger.kernel.org

Ar Iau, 2006-10-19 am 09:41 -0600, ysgrifennodd Matthew Wilcox:
> Signed-off-by: Matthew Wilcox <matthew@wil.cx>
> 

Acked-by: Alan Cox <alan@redhat.com>

Add a note to the block call that anyone blocking it for long times will
be unpopular.
