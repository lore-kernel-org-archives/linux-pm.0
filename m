From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / wakeup: use seq_open() to show wakeup stats
Date: Fri, 2 Mar 2018 10:12:01 +0100
Message-ID: <CAJZ5v0hjRMRBMrMZMQnK74vdmKxRvmghd9yx-on4hUCxdHWXMg@mail.gmail.com>
References: <1519966860-32519-1-git-send-email-opensource.ganesh@gmail.com> <20180302090546.GB30267@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180302090546.GB30267@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Ganesh Mahendran <opensource.ganesh@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 2, 2018 at 10:05 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Fri 2018-03-02 13:01:00, Ganesh Mahendran wrote:
>> single_open() interface requires that the whole output must
>> fit into a single buffer. This will lead to timeout when
>> system memory is not in a good situation.
>>
>> This patch use seq_open() to show wakeup stats. This method
>> need only one page, so timeout will not be observed.
>
> Can the rcu_read_unlock be delayed arbitrarily by userland code?
>
> Is that ok with RCU?

No, it isn't. :-)
