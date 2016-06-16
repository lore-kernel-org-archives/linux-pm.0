From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM: Make pm_prepare_console() return void
Date: Thu, 16 Jun 2016 15:59:18 +0200
Message-ID: <10638523.VnEGpRQZuu@vostro.rjw.lan>
References: <1465914202-423-1-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465914202-423-1-git-send-email-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 14, 2016 04:23:22 PM Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Nothing is using its return value so change it to return void.
> 
> No functionality change.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Applied, thanks!
