From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 04/22] idle/intel: Convert to hotplug state machine
Date: Tue, 29 Nov 2016 10:40:00 +0100
Message-ID: <20161129094000.5wqdcjutlx57kq4i@linutronix.de>
References: <20161126231350.10321-1-bigeasy@linutronix.de>
 <20161126231350.10321-5-bigeasy@linutronix.de>
 <alpine.DEB.2.20.1611281828050.3512@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1611281828050.3512@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, rt@linutronix.de, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2016-11-28 18:29:41 [+0100], Thomas Gleixner wrote:
> Why do you want to store that. There is no exit function AFAICT.

There was one until 02c4fae9ea68 ("drivers/idle: make intel_idle.c
driver more explicitly non-modular"). I am going to remove it…

> Thanks,
> 
> 	tglx

Sebastian
