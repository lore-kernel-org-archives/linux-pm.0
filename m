From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v1 2/3] of: Add support for reading a s32 from a
 multi-value property.
Date: Mon, 22 Aug 2016 15:51:57 +0100
Message-ID: <20160822145157.GD30850@leverpostej>
References: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com>
 <1471315139-28285-3-git-send-email-finley.xiao@rock-chips.com>
 <1471616119.61594.465.camel@infradead.org>
 <4975010.IL95Y3Sj1J@phil>
 <1471639654.4611.2.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471639654.4611.2.camel@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Finlye Xiao <finley.xiao@rock-chips.com>, srinivas.kandagatla@linaro.org, maxime.ripard@free-electrons.com, robh+dt@kernel.org, frowand.list@gmail.com, sre@kernel.org, dbaryshkov@gmail.com, khilman@kernel.org, nm@ti.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, jay.xu@rock-chips.com, rocky.hao@rock-chips.com, tim.chen@rock-chips.com, tony.xie@rock-chips.com, ulysses.huang@rock-chips.com, lin.huang@rock-chips.com
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 19, 2016 at 09:47:34PM +0100, David Woodhouse wrote:
> On Fri, 2016-08-19 at 22:41 +0200, Heiko Stuebner wrote:
> > 
> > > So no, don't *add* any more of these functions. Only add the generic
> > > version. And if your driver isn't using the generic property
> > > functions... fix it.
> > 
> > As far as I can see, all the device_property_* functions are grounded on their
> > of_property_*, acpi_property_* etc counterparts and functions reading specific
> > elements (the _index variants) are currently not available at all.
> > 
> > drivers/base/property.c:
> > #define OF_DEV_PROP_READ_ARRAY(node, propname, type, val, nval)                         \
> >         (val) ? of_property_read_##type##_array((node), (propname), (val), (nval))      \
> >               : of_property_count_elems_of_size((node), (propname), sizeof(type))
> > 
> > So even if you're using the device_property_* functions you'd still need
> > a match in the underlying functions or am I missing something?
> 
> Yes, but the underlying function should never be used directly by
> drivers. 

There are properties which never make sense with ACPI, and there are
drivers which shouldn't exist in the case of ACPI (due to clashes with
core ACPI functionality). So using of_property_* for those, and not
matching any ACPI tables is perfectly fine.

IMO, an of_property_read_s32_index() function is perfectly fine (as is
an ACPI-specific variant, or a unified helper, if that's useful to some
driver).

There is no need to force drivers to superficially appear to support
ACPI when they have not been designed with ACPI in mind, and are
unlikely to function in an ACPI environment.

Thanks,
Mark.
