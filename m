From: Tim Bird <tim.bird@sonymobile.com>
Subject: Re: [PATCH] power: qcom_smbb: Add otg regulator for control of vbus
Date: Tue, 8 Dec 2015 10:49:41 -0800
Message-ID: <56672645.9090909@sonymobile.com>
References: <1445548337-14612-1-git-send-email-tim.bird@sonymobile.com>
 <20151205160717.GA30410@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151205160717.GA30410@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tbird20d@gmail.com" <tbird20d@gmail.com>, =?UTF-8?Q?Andersson=2c_Bj=c3=b6rn?= <Bjorn.Andersson@sonymobile.com>
List-Id: linux-pm@vger.kernel.org



On 12/05/2015 08:07 AM, Sebastian Reichel wrote:
> Hi Tim,
> 
> On Thu, Oct 22, 2015 at 02:12:17PM -0700, Tim Bird wrote:
>> Add a regulator to control the OTG chargepath switch.  The OTG
>> switch gets its power from pm8941_5vs1, and that should be expressed
>> as an usb_otg_in-supply property in the DT node for the charger driver.
>> The regulator name is "otg".  This is used by USB code to control VBUS
>> direction.
> 
> I could not find a newer version of this patch with the comments
> from Mark being fixed. Did I miss anything?
No.  I thought I had sent out the follow-up for this, but
apparently I did not.  I'm re-testing it now, and plan to
send it out today.

Sorry about that.  I got sidetracked in the last month on some
other USB issues (not the host side, which is what requires
this patch).
 -- Tim
