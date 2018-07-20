From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] Optimize C3 entry on Centaur CPUs
Date: Fri, 20 Jul 2018 08:38:19 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1807200837380.1693@nanos.tec.linutronix.de>
References: <1527588757-19229-1-git-send-email-davidwang@zhaoxin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527588757-19229-1-git-send-email-davidwang@zhaoxin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Wang <davidwang@zhaoxin.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, len.brown@intel.com, pavel@ucw.cz, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@kernel.org, LKML <linux-kernel@vger.kernel.org>, brucechang@via-alliance.com, cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, benjaminpan@viatech.com, lukelin@viacpu.com, timguo@zhaoxin.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 29 May 2018, David Wang wrote:

> For new Centaur CPUs the ucode will take care of the preservation of cache coherence
> between CPU cores in C-states regardless of how deep the C-states are. So, it is not
> necessary to flush the caches in software befor entering C3.
> 
> Signed-off-by: David Wang <davidwang@zhaoxin.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
