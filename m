From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
Date: Wed, 2 Sep 2015 13:58:36 -0500
Message-ID: <CAL_JsqKMGp+3Z+oO6E0YYzjTCb=-R_QM=YF=B33NWayWmV057A@mail.gmail.com>
References: <20150811080023.GB5509@linux> <20150811093039.GA18282@x1>
 <20150811100941.GG5509@linux> <20150811115425.GE18282@x1> <20150811120124.GH5509@linux>
 <20150811132756.GG18282@x1> <20150811142812.GJ5509@linux> <20150811151736.GO18282@x1>
 <20150812110841.GC20238@linux> <20150826120628.GZ19409@x1> <20150902080639.GA26744@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150902080639.GA26744@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, kernel@stlinux.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Ajit Pal Singh <ajitpal.singh@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 2, 2015 at 3:06 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 26-08-15, 13:06, Lee Jones wrote:
>> On Wed, 12 Aug 2015, Viresh Kumar wrote:
>>
>> > On 11-08-15, 16:17, Lee Jones wrote:
>> > > This would work if we only had a single variable to contend with, but
>> > > what I showed you in my previous example is that we have 3 variables
>> > > to consider; cut (version), pcode and substrate.
>> > >
>> > > Using the two (simple) examples I provided, how would your suggestion
>> > > look in our case?
>> >
>> > So the solution I gave is for picking the microvolt based on pcode.
>> > The other two (cut, substrate) aren't about picking microvolt, but if
>> > the OPP is available or not. Right?
>>
>> 'pcode', 'cut' and 'substrate' all determine whether a given set of
>> OPPs an be used on the running platform.  I do not believe that you
>> can differentiate between them.
>>
>> > If these terms are generic enough, then we can add something similar
>> > to what you have added..
>>
>> If it makes it easier, you can treat them as version numbers 2.2.1
>> <pcode.cut.substrate>, but I don't see how this can help.  Obviously
>> this becomes more difficult when you add wild cards to the OPPs, where
>> a particular OPP would be suitable for all cuts for example.
>>
>> If you still think you can come up with a generic method to lay out
>> CPUFreq OPP nodes that will satisfy all vendors and not be a mass of
>> 10's of separate nodes, then great.  Again, I'm struggling to see how
>> that might be possible.
>>
>> What I believe we shouldn't do, is have this blocked forever for the
>> sake of adding a couple of vendor properties however.
>
> I agree and can understand the pain you are feeling..
>
> @Rob/Stephen: Please close this thread soon and let Lee get his work
> done :)

What do you expect here? It is your job to close it. Ultimately, this
will be your problem to deal with. If you have 10 different vendors
doing selection of OPPs in 10 different ways you will not be able to
change that easily later. Maybe if you can't come up with something
common, then this should just not go into DT. You can always look at
how to do this in a common way and move from the kernel to DT later.

Rob
