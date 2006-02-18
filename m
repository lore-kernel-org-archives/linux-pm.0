From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 1/5] [pm] Fix locking of device suspend/resume functions
Date: Sat, 18 Feb 2006 10:22:16 +0100
Message-ID: <1140254536.2968.14.camel@laptopd505.fenrus.org>
References: <Pine.LNX.4.50.0602171756520.30811-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751085AbWBRJWW@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0602171756520.30811-100000@monsoon.he.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: greg@kroah.com, torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2006-02-17 at 18:03 -0800, Patrick Mochel wrote:
> This patch removes the unneeded down()/up() calls from
> suspend_device() and resume_device(). Those functions
> are already called under the dpm_sem, making this code
> unconditionally deadlock in SMP kernels.

this wants to be a mutex as well ;)
