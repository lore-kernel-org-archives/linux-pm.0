From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 02/10] x86, olpc: Don't split string literals when fixing
 up the DT
Date: Sat, 23 Mar 2019 00:18:35 +0100 (CET)
Message-ID: <alpine.DEB.2.21.1903230017190.2157@nanos.tec.linutronix.de>
References: <20190310162419.11861-1-lkundrak@v3.sk> <20190310162419.11861-3-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190310162419.11861-3-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Sebastian Reichel <sre@kernel.org>, Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, 10 Mar 2019, Lubomir Rintel wrote:

Please use 'x86/platform/olpc:' as prefix in the subject.

> It was pointed out in a review, and checkpatch.pl complains about this.
> Breaking it down into multiple ofw evaluations works just as well, and
> perhaps even reads better.

perhaps?

Other than that:

Acked-by: Thomas Gleixner <tglx@linutronix.de>
