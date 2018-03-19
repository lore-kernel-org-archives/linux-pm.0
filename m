From: Woody Suwalski <terraluna977@gmail.com>
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
Date: Mon, 19 Mar 2018 05:17:45 -0400
Message-ID: <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
References: <20180318104023.GA10392@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180318104023.GA10392@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>
Cc: Netdev list <netdev@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
> With recent linux-next, after resume networkmanager often claims that
> "network is disabled". Sometimes suspend/resume clears that.
>
> Any ideas? Does it work for you?
> 									Pavel
Tried the 4.16-rc6 with nm 1.4.4 - I do not see the issue.

Woody
