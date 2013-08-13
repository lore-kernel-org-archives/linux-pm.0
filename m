From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
Date: Wed, 14 Aug 2013 07:08:23 +1000
Message-ID: <1376428103.4255.15.camel@pasglop>
References: <5208E2D3.7060005@arm.com> <3356439.a21MloFP7n@vostro.rjw.lan>
 <520A536C.3030600@arm.com>
 <CAL_JsqJdGXuTmb2kgBwgmRYGs9f92-dsawDXSXjmJW8cwjFVQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqJdGXuTmb2kgBwgmRYGs9f92-dsawDXSXjmJW8cwjFVQQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robherring2@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "Rafael J.
 Wysocki" <rjw@sisk.pl>, Olof Johansson <olof@lixom.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2013-08-13 at 13:44 -0500, Rob Herring wrote:
> It is up to Rafael if he is willing/able to rebase his tree, but I
> would drop this series until this is sorted out. I think the new
> common function should be and can be generalized to work for powerpc.
> It would need to make reg property optional and pass in the device
> node to the arch specific function.
> 
> A short term solution would be just to make the function "#ifndef
> CONFIG_PPC".

Please, no ifdef's with different signatures. Let's agree on the
prototype first (ie, thread output argument) and make the generic
one weak.

Cheers,
Ben.
