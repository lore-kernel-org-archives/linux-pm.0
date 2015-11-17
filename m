From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2] thermal: of-thermal: Reduce log level for message
 when can't find thermal zone
Date: Mon, 16 Nov 2015 19:37:02 -0800
Message-ID: <20151117033701.GB27415@localhost.localdomain>
References: <1447728214-31097-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447728214-31097-1-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 17, 2015 at 11:43:34AM +0900, Jiada Wang wrote:
> Some systems register thermal zone by themself and don't need to
> have thermal zones node in DT. Therefore reduce the log level from
> ERROR to DEBUG when thermal zone node can't be found in
> of_thermal_destroy_zones().


This is already applied [1]. I applied V1 though.
What is the difference from v1?

[1] -
https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal.git/commit/?h=fixes&id=285249884ec19480f99c011d223760bb1fc865a2

BR,

Eduardo Valentin
