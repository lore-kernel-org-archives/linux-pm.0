From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: x32 suspend failuer in Re: linux-next: Tree for Apr 4
Date: Wed, 4 Apr 2018 09:58:17 +0200
Message-ID: <CAJZ5v0hxyXtyKacJufivL9HWbQBsxTBYVipnHK4+QquTYjpc+A@mail.gmail.com>
References: <20180404165559.4cd0c12c@canb.auug.org.au> <20180404075047.GB9342@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180404075047.GB9342@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 4, 2018 at 9:50 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> Please do not add any v4.18 destined stuff to your linux-next included
>> trees until after v4.17-rc1 has been released.
>
> On thinkpad x60, suspend does not suspend at all with this -next
> version. Previous versions suspended/resumed fine but broke networking.
>
> Any ideas? I guess bisecting on next would not be easy?

Well, why would it be different from a bisect on any other git repo?
