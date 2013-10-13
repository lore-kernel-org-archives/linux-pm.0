From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] platform: x86: asus-wmi: add fan control
Date: Sun, 13 Oct 2013 03:49:41 -0500
Message-ID: <CAMP44s3KVJwTwpxG14k22Q47UXGYFHLQ9ZmWcEdHWiUkbahoaA@mail.gmail.com>
References: <1381236524-19633-1-git-send-email-felipe.contreras@gmail.com>
	<CAHR064ge8zew7uMeD+_LXR3ju5ARGG1y8utLOFzOLexny_DPLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAHR064ge8zew7uMeD+_LXR3ju5ARGG1y8utLOFzOLexny_DPLA@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>, Linux PM <linux-pm@vger.kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 10, 2013 at 10:59 AM, Corentin Chary
<corentin.chary@gmail.com> wrote:
>
>
>
> On Tue, Oct 8, 2013 at 1:48 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>
>> Simple driver to enable control of the fan in ASUS laptops. So far this
>> has only been tested in ASUS Zenbook Prime UX31A, but according to some
>> online reference [1], it should work in other models as well.
>>
>> The implementation is very straight-forward, the only caveat is that the
>> fan speed needs to be saved after it has been manually changed because
>> it won't be reported properly until it goes back to 'auto' mode.
>
> This doesn't really seems to be related to wmi, and is likely to be
> available only on a subset of models. Maybe it should a separate driver
> instead ?

The first patch I sent was standalone, and you said it should be wmi,
and now I do it wmi, and you said it should be separate. Which is it?

-- 
Felipe Contreras
