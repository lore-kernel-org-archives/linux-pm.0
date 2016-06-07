From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC] x86, hotplug: Use zero page for monitor when
 resuming from hibernation
Date: Tue, 7 Jun 2016 17:43:15 +0800
Message-ID: <57569733.7030505@intel.com>
References: <1465222749-8388-1-git-send-email-yu.c.chen@intel.com>
 <20160607080307.GB13858@amd> <57568968.2090100@intel.com>
 <20160607091349.GA1170@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160607091349.GA1170@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>, x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, Zhu Guihua <zhugh.fnst@cn.fujitsu.com>, Juergen Gross <jgross@suse.com>, "Zheng, Lv" <lv.zheng@intel.com>, Brian Gerst <brgerst@gmail.com>
List-Id: linux-pm@vger.kernel.org



On 2016=E5=B9=B406=E6=9C=8807=E6=97=A5 17:13, Borislav Petkov wrote:
> On Tue, Jun 07, 2016 at 04:44:24PM +0800, Chen Yu wrote:
>> I'm doing more test to verify this.
> I think it would be better if you looked into doing HLT as Brian
> suggested, instead of touching any memory during s/r.
>
OK, I'll also test this solution. thanks.
