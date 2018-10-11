From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v8 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Date: Thu, 11 Oct 2018 14:43:33 +0200
Message-ID: <20181011124333.GA10790@centauri.lan>
References: <1537698793-15285-1-git-send-email-tdas@codeaurora.org>
 <1537698793-15285-3-git-send-email-tdas@codeaurora.org>
 <20181004210407.GB7926@centauri.lan>
 <40719973-21a0-120d-7193-8e6287cbbd18@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <40719973-21a0-120d-7193-8e6287cbbd18@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 11, 2018 at 04:45:25PM +0530, Taniya Das wrote:

> > WARNING: Duplicate signature
> > #370:
> > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> >
> > If you are more than one author, you can use the Co-Developed-by tag.
> >
>
> Hmm, I do see multiple SOBs being used and merged.
>

>From Documentation/process/submitting-patches.rst:

"""
A Co-Developed-by: states that the patch was also created by another developer
along with the original author.  This is useful at times when multiple people
work on a single patch.  Note, this person also needs to have a Signed-off-by:
line in the patch as well.
"""

So it is not wrong to have two Signed-off-bys, just that
having the Co-Developed-by tag clearly shows that there
was more than one author.

Without the Co-Developed-by tag, the second Signed-off-by tag
is ambiguous, since the seconds Signed-off-by tag might just
have meant that that person was in the delivery chain of the
patch.

I think that the Co-Developed-by tag is optional, so if the
co-developer doesn't care about taking credit, it can probably
be skipped.


Kind regards,
Niklas
