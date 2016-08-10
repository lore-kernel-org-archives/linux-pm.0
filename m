From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] max17042_battery: fix model download bug.
Date: Wed, 10 Aug 2016 10:27:07 +0200
Message-ID: <6db1eb24-d659-e424-9da7-39cabd6ad5ee@samsung.com>
References: <CAGngYiVv=+RKDcuwqPxyg5GpU6iCBkuR2v7EFmnDM3Xf+w0b_g@mail.gmail.com>
 <20160809185429.GB19946@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160809185429.GB19946@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Sven Van Asbroeck <thesven73@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Jonghwa Lee <jonghwa3.lee@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-pm@vger.kernel.org

On 08/09/2016 08:54 PM, Sebastian Reichel wrote:
> Hi,
> 
> [adding some people to CC]
> 
> On Wed, Aug 03, 2016 at 10:03:46AM -0400, Sven Van Asbroeck wrote:
>> The device's model download function returns the model data as
>> an array of u32s, which is later compared to the reference
>> model data. However, since the latter is an array of u16s,
>> the comparison does not happen correctly, and model verification
>> fails. This in turn breaks the POR initialization sequence.
> 
> Patch looks ok, except for missing Fixes. I guess it should be
> "Fixes: 39e7213edc4f3". I will wait with queuing it for a few
> days giving Samsung people a chance to reply.

Looks correct.
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Also:
Cc: <stable@vger.kernel.org>

And how about:
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
https://www.marc.info/?l=linux-pm&m=143954612610000&w=4

Best regards,
Krzysztof
