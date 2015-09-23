From: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 09/11] power: bq24257: Allow input current limit sysfs
 access
Date: Wed, 23 Sep 2015 09:11:46 -0500
Message-ID: <20150923141146.GA6289@borg>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
 <1442612399-341-10-git-send-email-dannenberg@ti.com>
 <20150922191649.GA9949@earth>
 <20150922221044.GB30297@beast>
 <20150923002906.GA4359@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150923002906.GA4359@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ramakrishna Pallala <ramakrishna.pallala-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 23, 2015 at 02:29:06AM +0200, Sebastian Reichel wrote:
> On Tue, Sep 22, 2015 at 05:10:45PM -0500, Andreas Dannenberg wrote:
> > On Tue, Sep 22, 2015 at 09:16:49PM +0200, Sebastian Reichel wrote:
> > > On Fri, Sep 18, 2015 at 04:39:57PM -0500, Andreas Dannenberg wrote:
> > > > This patch allows reading (and writing, if the D+/D- USB signal-based
> > > > charger type detection is disabled) of the input current limit through
> > > > the power supply's input_current_limit sysfs property. This allows
> > > > userspace to see what charger was detected and to re-configure the
> > > > maximum current drawn from the external supply at runtime based on
> > > > system-level knowledge or user input.
> > > 
> > > Maybe also support writing into input_current_limit in auto mode.
> > > Just disable auto detection until "auto" is written into sysfs node.
> > 
> > Auto-detection was enabled by default in the original driver so I think
> > that should be left intact. I added the ability to manually override
> > this via DT with a fixed value, and then configure said fixed value
> > through sysfs at runtime.
> > 
> > I'm not 100% clear on the usecase of runtime enabling/disabling auto so
> > I'd rather leave the implementation as-is. Either auto mode is enabled
> > or not -- and this is directly tied to the DT setting. But if someone
> > has a strong usecase for this I can certainly add it.
> 
> For some usb power supplies auto-detection doesn't work very well,
> resulting in a 100mA default fallback. Users knowing their hardware
> could force charging with the correct input current limitation.

Ok. So how should we best go about extending the usage of the
'input_current_limit' sysfs node for this charger? You mentioned
writing 'auto' into it should enable the auto-detection mode. I suppose
writing a fixed current value will disable it. But how to indicate to
the user when reading 'input_current_limit' whether auto mode is enabled
or not (I think this is something we should do). Can we return a mixed
number/string like this?

# Example: charger auto detection mode is disabled, and input current
# limit is configured as 500mA.

$ cat input_current_limit
500000

# Example: charger auto detection mode is enabled, and a charger
# supporting 1A was detected (note the mixed number/string thats
# returned)

$ cat input_current_limit
1000000 (auto)

Would that work? Or should we introduce a new sysfs property?

--
Andreas Dannenberg
Texas Instruments Inc

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
