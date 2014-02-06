From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] ARM64: powernv: remove redundant cpuidle_idle_call()
Date: Thu, 6 Feb 2014 16:20:52 +0000
Message-ID: <CAKnoXLwk6H-JXeju4WV7PSswH_ei10Q3AhHf22zfDo0Y=VqDdg@mail.gmail.com>
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
 <1391696188-14540-2-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7105464756543347728=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1391696188-14540-2-git-send-email-nicolas.pitre@linaro.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Linux ARM Kernel ML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

--===============7105464756543347728==
Content-Type: multipart/alternative; boundary=001a1136b262d3cb0104f1bf414b

--001a1136b262d3cb0104f1bf414b
Content-Type: text/plain; charset=ISO-8859-1

On 6 February 2014 14:16, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:

> The core idle loop now takes care of it.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

--001a1136b262d3cb0104f1bf414b
Content-Type: text/html; charset=ISO-8859-1

<div dir="ltr"><div class="gmail_extra"><div class="gmail_quote">On 6 February 2014 14:16, Nicolas Pitre <span dir="ltr">&lt;<a href="mailto:nicolas.pitre@linaro.org" target="_blank">nicolas.pitre@linaro.org</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">The core idle loop now takes care of it.<br>
<br>
Signed-off-by: Nicolas Pitre &lt;<a href="mailto:nico@linaro.org">nico@linaro.org</a>&gt;<br></blockquote><div><br></div><div>Acked-by: Daniel Lezcano &lt;<a href="mailto:daniel.lezcano@linaro.org">daniel.lezcano@linaro.org</a>&gt;</div>
<div><br></div></div></div></div>

--001a1136b262d3cb0104f1bf414b--

--===============7105464756543347728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
--===============7105464756543347728==--
