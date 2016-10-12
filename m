From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / devfreq: Add proper locking around list_del()
Date: Wed, 12 Oct 2016 22:10:08 +0200
Message-ID: <5288115.te6OnEXYK7@vostro.rjw.lan>
References: <1475115208-6817-1-git-send-email-axel.lin@ingics.com> <CAJ0PZbSrd9Xi=YZJF_XarRYj1tb75L8_Bgc=T1iMsMB3YLnzDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJ0PZbSrd9Xi=YZJF_XarRYj1tb75L8_Bgc=T1iMsMB3YLnzDQ@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@gmail.com, Axel Lin <axel.lin@ingics.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, September 30, 2016 10:46:39 PM MyungJoo Ham wrote:
> On Thu, Sep 29, 2016 at 11:13 AM, Axel Lin <axel.lin@ingics.com> wrote:
> > Use devfreq_list_lock around list_del() to prevent list corruption.
> >
> > Signed-off-by: Axel Lin <axel.lin@ingics.com>
> 
> LGTM.
> 
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Applied.

Thanks,
Rafael
