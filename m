From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: Re: [PATCH] PM / OPP: discard duplicate OPP additions
Date: Thu, 15 May 2014 14:16:56 +0530
Message-ID: <CANuQgHEECW3c2C5+h7vUp5RuWJin3PPaos_BY1VoqzR=jTwGFQ@mail.gmail.com>
References: <1399966890-22926-1-git-send-email-k.chander@samsung.com>
	<CAGo_u6qTZ-yq26+K5nHut92d=-9nrCHKDNK9EMLK5kGMQc+dOw@mail.gmail.com>
	<CANuQgHGehqDD8-SKTfEKMEZmT5KwofFL8bhYqge0uNm6kpPgUQ@mail.gmail.com>
	<CAKohponfdoPG7H4h-5s+V7CwB_SgnyqqUm9aa6G-K_cX3DOcfA@mail.gmail.com>
	<53737D34.5040307@ti.com>
	<CANuQgHG23F7zGxbNJVzGAeCsNNPU_CwSu5veK2-CCjnc1RE-UQ@mail.gmail.com>
	<CAKohpo=O_=PVpFCnTWA=0R6deMFHgWx8dxOecro1dMwGVwxong@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=O_=PVpFCnTWA=0R6deMFHgWx8dxOecro1dMwGVwxong@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 15 May 2014 13:57, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 15 May 2014 13:55, Chander Kashyap <chander.kashyap@linaro.org> wrote:
>> Then in that case the caller must take care for two type of errors:
>> -EEXIST and -ENOMEM
>
> Actually, success: (0 or -EEXIST), failure: Anything else.

Yes exactly. All users of this API need to be modified to handle
EEXIST as success.

To avoid this returning 0 was suggested,

-- 
with warm regards,
Chander Kashyap
