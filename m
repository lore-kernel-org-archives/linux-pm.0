From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/2] max8903: adds support for initiation via device tree.
Date: Fri, 10 Jun 2016 08:13:28 +0200
Message-ID: <575A5A88.3070404@samsung.com>
References: <1464849897-21527-1-git-send-email-chris@lapa.com.au>
 <1464849897-21527-2-git-send-email-chris@lapa.com.au>
 <CAJKOXPdNZbY6=sUbu2Q+pR-PwAD92H5jm5JzmwnBdCbvk3F6KQ@mail.gmail.com>
 <98c757cd-d1b4-1599-ebb3-2a9cc3fc478d@lapa.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <98c757cd-d1b4-1599-ebb3-2a9cc3fc478d@lapa.com.au>
Sender: linux-kernel-owner@vger.kernel.org
To: chris@lapa.com.au
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/10/2016 07:35 AM, Chris Lapa wrote:
> Hi Krzysztof,
> 
> Thanks for the review. I'm working on those changes now.
> 
> However just so I know for the future. Why no error checking on
> devm_kzalloc() result? Looking through the source for devm_kzalloc() it
> looks like NULL isn't caught anywhere else.

Error checking is necessary. Just do not print the error message. The
kernel core will print one with full back trace.

if (charger == NULL)
	return -ENOMEM;


Best regards,
Krzysztof
