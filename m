From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 10/12] PM / devfreq: Remove 'devfreq' prefix from helper
 function
Date: Mon, 28 Aug 2017 01:37:30 +0000
Message-ID: <20170828013730epcms1p1d71f5a81bb83fe1db15f36ee73da7109@epcms1p1>
References: <1503538979-22693-11-git-send-email-cw00.choi@samsung.com>
        <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014300epcas2p452c864106cf4fd9754d075d57b8a9ca1@epcms1p1>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503538979-22693-11-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "chanwoo@kernel.org" <chanwoo@kernel.org>, Inki Dae <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> This patch just removes the 'devfreq' prefix from internal helper
> function in order to clarify the role of the following functions.
> - devfreq_get_freq_level() - get_freq_level()
> - devfreq_set_freq_table() - set_freq_table()
> 
> Also, this patch changes the return value of set_freq_table()
> from 'void' to 'int' and then removes the function description
> of internal helper function. Because the internal helper function
> is used by the devfreq core.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


(note that you are alternating betgween two email addresses, gmail.com/samsung.com in a single series of commits)
