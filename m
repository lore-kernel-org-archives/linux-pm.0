From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / sleep: make pm notifier called symmetrically
Date: Mon, 04 Jul 2016 15:08:09 +0200
Message-ID: <2216193.VQsjbIr0Ni@vostro.rjw.lan>
References: <1466405547-3830-1-git-send-email-lianwei.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466405547-3830-1-git-send-email-lianwei.wang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lianwei Wang <lianwei.wang@gmail.com>
Cc: tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org, oleg@redhat.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, June 19, 2016 11:52:27 PM Lianwei Wang wrote:
> This makes pm notifier PREPARE/POST symmetrical: if PREPARE
> fails, we will only undo what ever happened on PREPARE.
> 
> It fixes the unbalanced cpu hotplug enable in cpu pm notifier.
> 
> Signed-off-by: Lianwei Wang <lianwei.wang@gmail.com>

Applied, thanks!
