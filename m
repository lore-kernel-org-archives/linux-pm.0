From: Bjorn Andersson <bjorn@kryo.se>
Subject: Re: [PATCH 0/5] Rename regulator_set_optimum_mode
Date: Wed, 25 Feb 2015 15:40:31 -0800
Message-ID: <CAJAp7Oi67uuLEsXZbfo68zVa1XTOVhr7Q+V6n7QKC7rnQTywyA@mail.gmail.com>
References: <1423712131-23795-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1423712131-23795-1-git-send-email-bjorn.andersson@sonymobile.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: "James E.J. Bottomley" <JBottomley@parallels.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Vinayak Holikatti <vinholikatti@gmail.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 11, 2015 at 7:35 PM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> Changing the name of the regulator_set_optimum_mode() to
> regulator_set_load() better reflects that the API is doing.
>

Any comments on this?

I'm going to propose a patch to the mmc framework calling this api, so
it would be good to know before I add another consumer of the api.

Regards,
Bjorn
