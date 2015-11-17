From: Catalin Crenguta <catalin.crenguta@gmail.com>
Subject: Re: Freescale IMX6 active cooling
Date: Tue, 17 Nov 2015 14:49:26 +0200
Message-ID: <CABH3fy-QPV1bv-WaO3mWVq2RN5=f-AnBHMgFTmmU-Ve3xgyUrw@mail.gmail.com>
References: <CABH3fy-He02iVU7FzqcPApPemeoqQP15+gr9+Hx87-OEBuHvCg@mail.gmail.com>
 <CAOMZO5AX9owvovpdmdr=rKNApbuNrkp9pKexJk_mMyMdH1=1qg@mail.gmail.com>
 <CALHpu37MNnzW=3YNKUq-aOHgF12EhjyN7g1juTwuMad_Xv891w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CALHpu37MNnzW=3YNKUq-aOHgF12EhjyN7g1juTwuMad_Xv891w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Nettleton <jon.nettleton@gmail.com>, Sean Cross <xobs@kosagi.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 17, 2015 at 11:38 AM, Jon Nettleton <jon.nettleton@gmail.com> wrote:
> I would recommend you take a look at the work that xobs did for the
> Novena Heirloom.  If you look at this branch starting around Aug 3 you
> can see where he has converted iMX6 to use generic thermal zones and
> adds support for for an active cooling device/fan.
> https://github.com/xobs/novena-linux/commits/v3.19-novena-etnadrm-r3?page=3
>
> -Jon
Thank you!
I have patched my 4.3 kernel (they don't apply cleanly but they are
straight forward to modify), added a gpio-fan and the corresponding
thermal-zone in my DTB and it works!
Sean Cross, are you interested in bringing this to mainline?
