From: Ingo Molnar <mingo@kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= Delete some
 unusefull operations for centaur CPU/platform
Date: Mon, 12 Mar 2018 09:40:33 +0100
Message-ID: <20180312084033.lignixrpg4ruoxbq@gmail.com>
References: <1519963908-4359-1-git-send-email-davidwang@zhaoxin.com>
 <20180304093146.rujp4f62fv6xotb7@gmail.com>
 <efc93496e4ba46958b7b09eff54c2ce2@zhaoxin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <efc93496e4ba46958b7b09eff54c2ce2@zhaoxin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Wang <DavidWang@zhaoxin.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "len.brown@intel.com" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, "linux-pm@kernel.org" <linux-pm@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Bruce Chang (VAS)" <BruceChang@via-alliance.com>, "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>, "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>, Benjamin Pan <BenjaminPan@viatech.com>, Luke Lin <LukeLin@viacpu.com>, "Tim Guo(BJ-RD)" <TimGuo@zhaoxin.com>, "Cobe Chen(BJ-RD)" <CobeChen@zhaoxin.com>, "Jiangbo Wang(BJ-RD)" <JiangboWang@zhaoxin.com>
List-Id: linux-pm@vger.kernel.org


* David Wang <DavidWang@zhaoxin.com> wrote:

> [David] pr->flags.has_cst means BIOS define valid C state table.  And at lease 
> define 2 entries. On all centaur platform which support C3, this condition is 
> always true.

> [David] Just as the following comment said, we need not execute WBINVD and 
> ARB_DISABLE/ARB_ENABLE when entering C3 if bm_check=1 and bm_control=0.  This 
> logic is valid for all platform not only for Centaur, I think.

Ok, fair enough!

Thanks,

	Ingo
