From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH 03/12] PM / devfreq: Move private devfreq_update_stats()
 into devfreq
Date: Mon, 28 Aug 2017 01:20:07 +0000
Message-ID: <20170828012007epcms1p4ca52fbc634832f8a54f111923281a915@epcms1p4>
References: <1503538979-22693-4-git-send-email-cw00.choi@samsung.com>
        <1503538979-22693-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170824014259epcas2p174f90081b192ae5239f0130413ba3845@epcms1p4>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503538979-22693-4-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "chanwoo@kernel.org" <chanwoo@kernel.org>, Inki Dae <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chanwoo Choi <cwchoi00@gmail.com>
List-Id: linux-pm@vger.kernel.org

> From: Chanwoo Choi <cwchoi00@gmail.com>
> 
> THe devfreq_update_stats() updates the 'struct devfreq_dev_status'
> in order to get current status of devfreq device. It is only used
> for the governors.
> 
> This patch moves the devfreq_update_stats() into devfreq directory.
> 
> Signed-off-by: Chanwoo Choi <cwchoi00@gmail.com>
> ---
>  drivers/devfreq/governor.h |  4 ++++
>  include/linux/devfreq.h    | 13 -------------
>  2 files changed, 4 insertions(+), 13 deletions(-)

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
