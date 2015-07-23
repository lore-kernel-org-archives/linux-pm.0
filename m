From: Mason <slash.tmp@free.fr>
Subject: Re: Using a temperature sensor with 1-bit output for CPU throttling
Date: Thu, 23 Jul 2015 14:51:49 +0200
Message-ID: <55B0E365.6000308@free.fr>
References: <553F6E85.5090402@free.fr> <5540E0E1.6080504@free.fr> <20150429163605.GM3054@e104805> <55AE0C7F.40506@free.fr> <55B0B1A5.9000909@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <55B0B1A5.9000909@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
Cc: Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel <amit.daniel@samsung.com>, Andrew Lunn <andrew@lunn.ch>, Lukasz Majewski <l.majewski@samsung.com>, Zoran Markovic <zoran.markovic@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 23/07/2015 11:19, Mason wrote:

> Does the cpu_cooling driver written by Amit Daniel also support
> disabling/off-lining entire cores in multi-core systems, not just
> throttling the frequency of the cores?

According to Javi Merino, the answer is no.

He also pointed out the latest attempt to merge such a feature:

[RFC PATCH] thermal: add generic cpu hotplug cooling device
http://thread.gmane.org/gmane.linux.documentation/15658

Regards.

