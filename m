From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 1/8] PM / Runtime: Fetch runtime PM callbacks using a
 macro
Date: Thu, 27 Feb 2014 22:13:51 +0100
Message-ID: <CAPDyKFq4X3G1zZay0XG2g-djEvyRdf9s47GDSC5htXZ7c-LdRQ@mail.gmail.com>
References: <CAPDyKFrbhmqmu-0uqX_U18nKXuu2z5ueYXqaz4LOHy=ijecs1g@mail.gmail.com>
 <Pine.LNX.4.44L0.1402271120280.888-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <Pine.LNX.4.44L0.1402271120280.888-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>, Josh Cartwright <joshc@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alessandro Rubini <rubini@unipv.it>
List-Id: linux-pm@vger.kernel.org

On 27 February 2014 17:22, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 27 Feb 2014, Ulf Hansson wrote:
>
>> > A reasonable compromise would be to define the macro, and then use it
>> > in those three new functions (and nowhere else).
>>
>> Okay, let me send a v3 that tries this approach then.
>>
>> >
>> > The existing rpm_idle, rpm_suspend, and rpm_resume routines should then
>> > be changed to use the new functions.  And of course, the new functions
>> > could be called directly by subsystems or PM domains.
>>
>> Not sure we should export these functions as a part of this patchset.
>> Would it not be preferred, to first see if there are any that needs
>> it?
>
> I don't understand.  V2 of the patchset exports
> pm_runtime_force_suspend and pm_runtime_force_resume.  Why wouldn't you
> want to export them in V3?

There are some confusion here. :-)  pm_runtime_force_suspend|resume()
surely need to be exported, but that's "patch v2 2/8".

I think we were debating whether this patch "patch v2 1/8" should use
a macro to walk the ladder to fetch the runtime PM callback - or if we
should implement a three c-functions to handle it. I prefer to keep
this patch as is, thus using the macro.

Kind regards
Ulf Hansson


>
> Alan Stern
>
