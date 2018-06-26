From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 1/1] device core: Add flag to autoremove device link on
 supplier unbind
Date: Tue, 26 Jun 2018 17:18:19 +0530
Message-ID: <CAFp+6iEapavf-Fta9Gs8Dg8g6CDtvymAWdjT=Jng7mnjiCNxpA@mail.gmail.com>
References: <20180530095704.5788-1-vivek.gautam@codeaurora.org>
 <541c84e9-47fc-e7bc-8249-1477b9e63455@codeaurora.org> <CAFp+6iGwcbOm0p33o9NEE7YBZNNvRsBeU0ySy0HcEmvq8mhBJA@mail.gmail.com>
 <6354476.UjADPVylrh@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6354476.UjADPVylrh@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Greg KH <gregkh@linuxfoundation.org>, lukas@wunner.de, dmitry.torokhov@gmail.com, aspriel@gmail.com, Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Tue, Jun 26, 2018 at 3:49 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, June 26, 2018 12:03:44 PM CEST Vivek Gautam wrote:
>> On Wed, May 30, 2018 at 6:21 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>
>> Adding Ulf and Marek for their side of comments.
>> In summary, we do not want to not maintain a device link pointer
>> when adding a device link in supplier's driver, to delete the link later.
>> An autoremove flag from the suppliers side (similar to what we already
>> have for consumer side) can help autoremove the device link
>> when supplier driver goes away.
>>
>> Hi Rafael, Lukas,
>> Gentle ping. Can you please consider reviewing this patch.
>
> ISTR telling you that I didn't like the DL_FLAG_AUTOREMOVE_S name
> as it is too similar to another existing flag.  That hasn't changed.

Right. I thought to gather more comments about the patch overall
before attempting to respin with the changed name.
I will send the next version.

>
> BTW, please CC the patch to linux-pm when you resend it.

Sure. I will do that. Thanks.

Best regards
Vivek

>
> Thanks,
> Rafael
>



-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
