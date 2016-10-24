From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
Date: Mon, 24 Oct 2016 11:34:28 +0100
Message-ID: <20161024103428.GA8574@dell>
References: <20161005155112.13774-1-hdegoede@redhat.com>
 <20161005155112.13774-2-hdegoede@redhat.com>
 <CAGb2v67iQikSHcwS15VmSC6fNMVG9Zya9fz6C6b5+wW43rPZfw@mail.gmail.com>
 <bbd16837-a260-b574-1b1a-1bede038e3de@redhat.com>
 <20161024100938.GI14477@dell>
 <20161024101659.GA1440@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161024101659.GA1440@katana>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>, Dennis Gilmore <dennis@ausil.us>, Maxime Ripard <maxime.ripard@free-electrons.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 24 Oct 2016, Wolfram Sang wrote:

> 
> > > > Even though axp20x-i2c seems to be the only "DT only" i2c client,
> > > > would it make sense to add DT-based module autoloading to the i2c
> > > > core?
> > > 
> > > If it is not too invasive, then yes that would be a sensible addition IMHO.
> > 
> > If I understand you correctly, I already have a patch-set on the ML
> > that does this.
> 
> Incomplete, though. But we will see if Kieran finds time somewhen...

I was under the impression it was all but ready.

What are you waiting on?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
