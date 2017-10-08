From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 0/2] detect identical chip data arrays
Date: Sun,  8 Oct 2017 21:18:39 +0200
Message-ID: <1507490321-24900-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <cocci-bounces@systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr
To: Liam Breck <liam@networkimprov.net>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, pali.rohar@gmail.com, Linux PM mailing list <linux-pm@vger.kernel.org>
Cc: kernel-janitors@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, Joe Perches <joe@perches.com>, kbuild test robot <fengguang.wu@intel.com>, cocci@systeme.lip6.fr
List-Id: linux-pm@vger.kernel.org

Rename battery.cocci as check_bq27xxx_data.cocci and adjust the warning
messages to indicate that some structures are the same, in response to
feedback from Liam Breck.

Although check_bq27xxx_data.cocci says is requires Coccinelle 1.0.7, which
is not yet released, it actually works with the version currently available
on Github, eg from Coccinelle commit 3ba77b3a0f91.

---

 scripts/coccinelle/api/battery.cocci            |  161 ------------------------
 scripts/coccinelle/api/check_bq27xxx_data.cocci |  161 ++++++++++++++++++++++++
 2 files changed, 161 insertions(+), 161 deletions(-)
