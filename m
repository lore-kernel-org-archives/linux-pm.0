From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 0/2] bug fixes for coupled cpuidle
Date: Fri, 1 Jun 2012 23:41:17 -0700
Message-ID: <CAMbhsRRDKBaRc3A3m-N+m9AyZsRXbgwg-oZ+ZFgf5HV_3Mcfvg@mail.gmail.com>
References: <1337364324-12171-1-git-send-email-ccross@android.com>
	<4FC9A9BA.1020904@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6649843642146208358=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FC9A9BA.1020904@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Kevin Hilman <khilman@ti.com>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@lists.linux-foundation.org, Arjan van de Ven <arjan@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

--===============6649843642146208358==
Content-Type: multipart/alternative; boundary=bcaec51d29c28f088304c1779668

--bcaec51d29c28f088304c1779668
Content-Type: text/plain; charset=ISO-8859-1

On Jun 1, 2012 10:50 PM, "Len Brown" <lenb@kernel.org> wrote:
>
> On 05/18/2012 02:05 PM, Colin Cross wrote:
>
> > The last modifications made to the coupled cpuidle patches introduced
> > two bugs that I missed during testing.  The online count was never
> > initialized, causing coupled idle to always wait and never enter the
> > ready loop.  That hid the second bug, the ready count could never be
> > decremented after exiting idle.
> >
> > Len, these two patches could be squashed into patch 3 of the original
> > set.  If you do squash them, you could also add Rafael's tags to the
> > set (Reviewed-by on 1 and 2, acked-by on 3).
>
>
> squash & tags update done.
>
> > Or I can reupload the
> > whole stack as v5 if you prefer.
>
>
> no need.
>
> thanks,
> -Len Brown, Intel Open Source Technology Center

Thanks!

--bcaec51d29c28f088304c1779668
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">On Jun 1, 2012 10:50 PM, &quot;Len Brown&quot; &lt;<a href=
=3D"mailto:lenb@kernel.org">lenb@kernel.org</a>&gt; wrote:<br>
&gt;<br>
&gt; On 05/18/2012 02:05 PM, Colin Cross wrote:<br>
&gt;<br>
&gt; &gt; The last modifications made to the coupled cpuidle patches introd=
uced<br>
&gt; &gt; two bugs that I missed during testing. =A0The online count was ne=
ver<br>
&gt; &gt; initialized, causing coupled idle to always wait and never enter =
the<br>
&gt; &gt; ready loop. =A0That hid the second bug, the ready count could nev=
er be<br>
&gt; &gt; decremented after exiting idle.<br>
&gt; &gt;<br>
&gt; &gt; Len, these two patches could be squashed into patch 3 of the orig=
inal<br>
&gt; &gt; set. =A0If you do squash them, you could also add Rafael&#39;s ta=
gs to the<br>
&gt; &gt; set (Reviewed-by on 1 and 2, acked-by on 3).<br>
&gt;<br>
&gt;<br>
&gt; squash &amp; tags update done.<br>
&gt;<br>
&gt; &gt; Or I can reupload the<br>
&gt; &gt; whole stack as v5 if you prefer.<br>
&gt;<br>
&gt;<br>
&gt; no need.<br>
&gt;<br>
&gt; thanks,<br>
&gt; -Len Brown, Intel Open Source Technology Center</p>
<p dir=3D"ltr">Thanks!</p>

--bcaec51d29c28f088304c1779668--

--===============6649843642146208358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6649843642146208358==--
