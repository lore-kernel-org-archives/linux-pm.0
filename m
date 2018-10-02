From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
Date: Tue, 2 Oct 2018 12:17:58 +0100
Message-ID: <20181002111758.GC1086@e107155-lin>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
 <20180831140151.13972-3-georgi.djakov@linaro.org>
 <20180925180215.GA12435@bogus>
 <b67253fb-d86d-2ddd-6c30-0833d6ed62ad@linaro.org>
 <20180926144830.GB25838@e107155-lin>
 <fa74c24f-1f22-f11f-60fe-5a4489d9c7c2@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fa74c24f-1f22-f11f-60fe-5a4489d9c7c2@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Georgi Djakov <georgi.djakov@linaro.org>, Rob Herring <robh@kernel.org>, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, mturquette@baylibre.com, khilman@baylibre.com, vincent.guittot@linaro.org, bjorn.andersson@linaro.org, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, evgreen@chromium.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 01, 2018 at 04:49:32PM -0700, Saravana Kannan wrote:
> On 09/26/2018 07:48 AM, Sudeep Holla wrote:
> > On Wed, Sep 26, 2018 at 05:42:15PM +0300, Georgi Djakov wrote:
> > > Hi Rob,
> > > 
> > > Thanks for the comments!
> > > 
> > > On 09/25/2018 09:02 PM, Rob Herring wrote:
> > > > On Fri, Aug 31, 2018 at 05:01:45PM +0300, Georgi Djakov wrote:
> > > > > This binding is intended to represent the relations between the interconnect
> > > > > controllers (providers) and consumer device nodes. It will allow creating links
> > > > > between consumers and interconnect paths (exposed by interconnect providers).
> > > > As I mentioned in person, I want to see other SoC families using this
> > > > before accepting. They don't have to be ready for upstream, but WIP
> > > > patches or even just a "yes, this works for us and we're going to use
> > > > this binding on X".
> > > Other than the 3 Qualcomm SoCs (msm8916, msm8996, sdm845) that are
> > > currently using this binding, there is ongoing work from at least two
> > > other vendors that would be using this same binding. I will check on
> > > what is their progress so far.
> > > 
> > > > Also, I think the QCom GPU use of this should be fully sorted out. Or
> > > > more generically how this fits into OPP binding which seems to be never
> > > > ending extended...
> > > I see this as a further step. It could be OPP binding which include
> > > bandwidth values or some separate DT property. Jordan has already
> > > proposed something, do you have any initial comments on that?
> > I am curious as how this fits into new systems which have firmware driven
> > CPUFreq and other DVFS. I would like to avoid using this in such systems
> > and leave it upto the firmware to scale the bus/interconnect based on the
> > other components that are connected to it and active.
> > 
> 
> You've made the same point multiple times across different patch sets. Not
> all FW can do arbitrary functions. A lot of them are very limited in their
> capabilities. So, as much as you and I would like to let the FW do the work,
> it's not always possible. So, in those cases, we do need to have support for
> the kernel scaling the interconnects correctly. Hopefully this clears up
> your questions about FW capabilities.

Yes, I do understand I have made the same point multiple time and it's
intentional. We need to get the fragmented f/w support story fixed.
Different ARM vendors are doing different things in f/w and ARM sees the
same fragmentation story as before. We have come up with new specification
and my annoying multiple emails are just to constantly remind the same.

I do understand we have existing implementations to consider, but fixing
the functionality in arbitrary way is not a good design and it better
to get them fixed for future.

--
Regards,
Sudeep
