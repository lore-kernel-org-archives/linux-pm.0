From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v1 2/3] of: Add support for reading a s32 from a multi-value property.
Date: Fri, 19 Aug 2016 22:41:24 +0200
Message-ID: <4975010.IL95Y3Sj1J@phil>
References: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com> <1471315139-28285-3-git-send-email-finley.xiao@rock-chips.com> <1471616119.61594.465.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471616119.61594.465.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Finlye Xiao <finley.xiao@rock-chips.com>, srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com, robh+dt@kernel.org, frowand.list@gmail.com, sre@kernel.org, dbaryshkov@gmail.com, mark.rutland@arm.com, khilman@kernel.org, nm@ti.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, jay.xu@rock-chips.com, rocky.hao@rock-chips.com, tim.chen@rock-chips.com, tony.xie@rock-chips.com, ulysses.huang@rock-chips.com, lin.huang@rock-chips.com
List-Id: linux-pm@vger.kernel.org

Am Freitag, 19. August 2016, 15:15:19 CEST schrieb David Woodhouse:
> On Tue, 2016-08-16 at 10:38 +0800, Finlye Xiao wrote:
> > From: Finley Xiao <finley.xiao@rock-chips.com>
> > 
> > This patch adds an of_property_read_s32_index() function to allow
> > reading a single indexed s32 value from a property containing multiple
> > s32 values.
> > 
> > Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> 
> NAK.
> 
> Nobody should be using the old of_property_* functions any more anyway.
> You should be using the generic device_propery_* functions which work
> regardless of where the information comes from (actual DT vs. ACPI
> _DSD).
>
> So no, don't *add* any more of these functions. Only add the generic
> version. And if your driver isn't using the generic property
> functions... fix it.

As far as I can see, all the device_property_* functions are grounded on their
of_property_*, acpi_property_* etc counterparts and functions reading specific
elements (the _index variants) are currently not available at all.

drivers/base/property.c:
#define OF_DEV_PROP_READ_ARRAY(node, propname, type, val, nval)				\
	(val) ? of_property_read_##type##_array((node), (propname), (val), (nval))	\
	      : of_property_count_elems_of_size((node), (propname), sizeof(type))

So even if you're using the device_property_* functions you'd still need
a match in the underlying functions or am I missing something?
