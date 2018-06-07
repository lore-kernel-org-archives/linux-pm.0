From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/acpi: fix the comments in acpi_parse_lapic
Date: Thu, 7 Jun 2018 14:09:17 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1806071407050.1596@nanos.tec.linutronix.de>
References: <1528371302-29270-1-git-send-email-lirongqing@baidu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528371302-29270-1-git-send-email-lirongqing@baidu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Li RongQing <lirongqing@baidu.com>
Cc: mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 7 Jun 2018, Li RongQing wrote:

> This should be permit to preallocate memory for all NR_CPUS

No. The comment is correct. The whole magic is there to size
num_possible_cpus correctly so that we can avoid allocating for NR_CPUS
which is most of the time larger than num_possible_cpus.

Thanks,

	tglx
