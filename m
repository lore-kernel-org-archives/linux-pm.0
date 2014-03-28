From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH] cpufreq: don't print value of .driver_data from core
Date: Fri, 28 Mar 2014 09:00:31 +0100
Message-ID: <20140328090031.5bb9a01f@amdc2363>
References: <2490cd0aaeaaeb88131c8089d491c485f08da5da.1395914766.git.viresh.kumar@linaro.org>
 <20140327104842.GB27777@in.ibm.com>
 <CAKohpombz9jzAs-_mpBNJyTJrrvvXVQ1L0V8fyKmB1vXpSPjmQ@mail.gmail.com>
 <20140327112602.GD27777@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <20140327112602.GD27777@in.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: ego@linux.vnet.ibm.com, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Hi Gautham,

> On Thu, Mar 27, 2014 at 04:29:37PM +0530, Viresh Kumar wrote:
> > On 27 March 2014 16:18, Gautham R Shenoy <ego@linux.vnet.ibm.com>
> > wrote:
> > > So after this patch, driver_data is only going to be used by
> > > drivers which want an "unsigned int" value to be saved along with
> > > the frequency in the frequency_table and for those who want to
> > > overload its interpretation to indicate BOOST.
> > >
> > > From the core's stand point, it is useful only for determining
> > > whether a frequency is BOOST frequency or not.
> > 
> > Yes.
> > 
> > > So, wouldn't it be logical to allow drivers maintain their own
> > > driver data since the core is anyway not interested in it, and
> > > change this .driver_data to "flags" or some such which can
> > > indicate boost ?
> > 
> > We can add another field .flags in case Rafael doesn't accept the
> > other proposal I sent for fixing BOOST issue.
> 
> Even with that patch, the .driver_data won't be opaque. And that's not
> good. Because, while some driver might not be explicitly setting the
> value of .driver_data to 0xABABABAB, it might want to store the value
> obtained at runtime into this field. And it could so happen
> that at runtime this value is 0xABABABAB.

The .driver_data initially stored the index of the freq_table. Even the
name was ".index" not .driver_data. The "index" name was informative
and reflected the purpose of the field. For this reason the BOOST
marker was fitted there, since BOOST is somewhat extra state.

Then the name was chaged to .drviver_data. This name indicates that
driver specific information can be stored there (in the uint32 format).

It would work if we stored there only flags (like it is now). However
Gutham proposed idea to store there the voltage value - preferably
stored as int.

For me it seems, like we are trying to mix arbitrary values and
predefined flags in one variable. In my opinion we should
split .driver_data field to two separate ones - namely .flags and
.driver_data.

Another solution, but NOT recommended by me, would be to split this
field to have 16 bits for flags (upper) and lower 16 bits for values.


> 
> > 
> > But the point behind keeping .driver_data field here was: many
> > drivers have some information attached to each frequency and they
> > are closely bound to each other. And so it made more sense to keep
> > them together. This is still used by many drivers and I wouldn't
> > like them to maintain separate arrays for keeping this information.
> > They are so much bound to the frequencies at the same index, that
> > keeping them separately wouldn't be a good idea.
> 
> I understand this part. However there might be more data than an
> "unsigned int" that the drivers would like to be bound at the same
> index. Voltage information, for instance.
> 
> > 
> --
> Thanks and Regards
> gautham.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
