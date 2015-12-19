From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] i2c: s3c2410: remove superfluous runtime PM calls
Date: Sat, 19 Dec 2015 12:05:15 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1512191202150.27155-100000@netrider.rowland.org>
References: <20151219105030.GA2571@katana>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20151219105030.GA2571@katana>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Sat, 19 Dec 2015, Wolfram Sang wrote:

> Asking linux-pm for help here: If we want to support RuntimePM for I2C
> clients, do we need to enable RuntimePM on the logical I2C adapter
> device (the bus master) which is already marked using
> pm_runtime_no_callbacks?

In theory you don't need to.  But there are some advantages if you do: 
You get automatic runtime PM time accounting for the adapter device 
(how much time active and how much suspended), and suspend events will 
propagate from the I2C clients all the way up to the adapter's parent.

Alan Stern
