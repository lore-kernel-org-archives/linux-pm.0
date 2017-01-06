From: Roger Shimizu <rogershimizu@gmail.com>
Subject: Re: [PATCH v3 2/3] DT: bingdings: power: reset: add linkstation-reset
 doc
Date: Fri, 6 Jan 2017 21:18:15 +0900
Message-ID: <CAEQ9gEkGKHXEqjcuR6nrV5XpLRvCFhaONjpPkeCx46ygD0K1UA@mail.gmail.com>
References: <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161227070611.14852-1-rogershimizu@gmail.com>
 <20161227070611.14852-3-rogershimizu@gmail.com>
 <20170103170952.7svgaa247ewlht7f@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170103170952.7svgaa247ewlht7f@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Ryan Tandy <ryan@nardis.ca>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Dear Rob,

Thanks for your comments!

On Wed, Jan 4, 2017 at 2:09 AM, Rob Herring <robh@kernel.org> wrote:
>
> This needs to model the uC connected to the UART rather than some node
> that defines only some portion of the functionality. I'm working on
> bindings and proper bus support for this[1], but it's not done yet.
> Though, the binding side is pretty simple.
>
> Rob
>
> [1] https://git.kernel.org/cgit/linux/kernel/git/robh/linux.git/log/?h=serial-bus-v2

Actually I have limited knowledge on DT binding.
I think it should be OK to remove the 2/3 patch (this thread) in my
next series, and I'll do my homework when you finish it.
Thank you!

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1
