From: wkq5325 <wkq5325@163.com>
Subject: why  menu.c in cpuidle   continue ?
Date: Mon, 27 Dec 2010 23:58:54 +0800 (CST)
Message-ID: <1a05924.a870.12d288dbfca.Coremail.wkq5325@163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8391153867013547812=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============8391153867013547812==
Content-Type: multipart/alternative;
	boundary="----=_Part_114121_21357466.1293465534409"

------=_Part_114121_21357466.1293465534409
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit

Hi,
I find the code in 2.6.36 menu.c (cpuidle)

  for (i = CPUIDLE_DRIVER_STATE_START; i < dev->state_count; i++) {
287                 struct cpuidle_state *s = &dev->states[i];
289                 if (s->flags & CPUIDLE_FLAG_IGNORE)
290                         continue;
291                 if (s->target_residency > data->predicted_us)
292                         continue;
293                 if (s->exit_latency > latency_req)
294                         continue;
Why continue? Not break ?? Before  2.6.36 , break is used here, I can understand.
But now , I don't know why continue for the remaining state??

wkq



------=_Part_114121_21357466.1293465534409
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: 7bit

Hi,<br>I find the code in 2.6.36 menu.c (cpuidle)<br><pre>  for (<a href="http://lxr.free-electrons.com/ident?i=i">i</a> = <a href="http://lxr.free-electrons.com/ident?i=CPUIDLE_DRIVER_STATE_START">CPUIDLE_DRIVER_STATE_START</a>; <a href="http://lxr.free-electrons.com/ident?i=i">i</a> &lt; <a href="http://lxr.free-electrons.com/ident?i=dev">dev</a>-&gt;state_count; <a href="http://lxr.free-electrons.com/ident?i=i">i</a>++) {<br><a name="L287" href="http://lxr.free-electrons.com/source/drivers/cpuidle/governors/menu.c#L287">287</a>                 struct <a href="http://lxr.free-electrons.com/ident?i=cpuidle_state">cpuidle_state</a> *<a href="http://lxr.free-electrons.com/ident?i=s">s</a> = &amp;<a href="http://lxr.free-electrons.com/ident?i=dev">dev</a>-&gt;<a href="http://lxr.free-electro
 ns.com/ident?i=states">states</a>[<a href="http://lxr.free-electrons.com/ident?i=i">i</a>];<a name="L288" href="http://lxr.free-electrons.com/source/drivers/cpuidle/governors/menu.c#L288"><!
 /a><br><a name="L289" href="http://lxr.free-electrons.com/source/drivers/cpuidle/governors/menu.c#L289">289</a>                 if (<a href="http://lxr.free-electrons.com/ident?i=s">s</a>-&gt;<a href="http://lxr.free-electrons.com/ident?i=flags">flags</a> &amp; <a href="http://lxr.free-electrons.com/ident?i=CPUIDLE_FLAG_IGNORE">CPUIDLE_FLAG_IGNORE</a>)<br><a name="L290" href="http://lxr.free-electrons.com/source/drivers/cpuidle/governors/menu.c#L290">290</a>                         continue;<br><a name="L291" href="http://lxr.free-electrons.com/source/drivers/cpuidle/governors/menu.c#L291">291</a>                 if (<a href="http://lxr.free-electrons.com/ident?i=s">s</a>-&gt;target_residency &gt; <a href="http://lxr.free-electrons.com/ident?i=data">data</a>-&gt;predicted_us)<br><a name="
 L292" href="http://lxr.free-electrons.com/source/drivers/cpuidle/governors/menu.c#L292">292</a>                         continue;<br><a name="L293" href="http://lxr.free-electrons.com/sourc!
 e/drivers/cpuidle/governors/menu.c#L293">293</a>                 if (<a href="http://lxr.free-electrons.com/ident?i=s">s</a>-&gt;exit_latency &gt; latency_req)<br><a name="L294" href="http://lxr.free-electrons.com/source/drivers/cpuidle/governors/menu.c#L294">294</a>                         continue;<br><a name="L295" href="http://lxr.free-electrons.com/source/drivers/cpuidle/governors/menu.c#L295"></a>Why continue? Not break ?? Before  2.6.36 , break is used here, I can understand.<br>But now , I don't know why continue for the remaining state??<br><br>wkq<br></pre><br>        
<br><br><span title="neteasefooter"><span id="netease_mail_footer"></span></span>
------=_Part_114121_21357466.1293465534409--


--===============8391153867013547812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8391153867013547812==--
