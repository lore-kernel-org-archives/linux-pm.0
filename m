From: "Gopi P.M." <tags07@gmail.com>
Subject: Re: [linux-pm] Power Mangement Interfaces
Date: Fri, 30 Mar 2007 23:33:06 -0500
Message-ID: <6efbedd10703302133k40d3a34dx13af817cbd7c62b2@mail.gmail.com>
References: <20070330235759.GC4252@cosmic.amd.com>
	<1175300283.23438.38.camel@johannes.berg>
	<1175300491.23438.40.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9084238246599099955=="
Return-path: <devel-bounces@laptop.org>
In-Reply-To: <1175300491.23438.40.camel@johannes.berg>
List-Unsubscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=unsubscribe>
List-Archive: <http://mailman.laptop.org/pipermail/devel>
List-Post: <mailto:devel@laptop.org>
List-Help: <mailto:devel-request@laptop.org?subject=help>
List-Subscribe: <http://mailman.laptop.org/mailman/listinfo/devel>,
	<mailto:devel-request@laptop.org?subject=subscribe>
Sender: devel-bounces@laptop.org
Errors-To: devel-bounces@laptop.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.osdl.org, devel@laptop.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============9084238246599099955==
Content-Type: multipart/alternative;
	boundary="----=_Part_65029_23487752.1175315586416"

------=_Part_65029_23487752.1175315586416
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 3/30/07, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Sat, 2007-03-31 at 02:18 +0200, Johannes Berg wrote:
>
> > > I am now turning my attention to handling wakeup events - in
> particular,
> > > events that we can set at run-time.  My thoughts on the matter are
> > > detailed here:
> > >
> > > http://wiki.laptop.org/go/Power_Management_Interface
>
> Hm, another thing. The RTC alarm wakeup event, wouldn't that require
> programming the time too? And if so, should that be done through the
> power interface to it?



I'd rather have a calendar app be the user interface to schedule wakeup via
RTC..that way any alarm or events you schedule would also wakeup the system
if it has gone into sleep mode.

Gopi

------=_Part_65029_23487752.1175315586416
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 3/30/07, <b class="gmail_sendername">Johannes Berg</b> &lt;<a href="mailto:johannes@sipsolutions.net">johannes@sipsolutions.net</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Sat, 2007-03-31 at 02:18 +0200, Johannes Berg wrote:<br><br>&gt; &gt; I am now turning my attention to handling wakeup events - in particular,<br>&gt; &gt; events that we can set at run-time.&nbsp;&nbsp;My thoughts on the matter are
<br>&gt; &gt; detailed here:<br>&gt; &gt;<br>&gt; &gt; <a href="http://wiki.laptop.org/go/Power_Management_Interface">http://wiki.laptop.org/go/Power_Management_Interface</a><br><br>Hm, another thing. The RTC alarm wakeup event, wouldn&#39;t that require
<br>programming the time too? And if so, should that be done through the<br>power interface to it?</blockquote><div><br>&nbsp;</div>I&#39;d rather have a calendar app be the user interface to schedule wakeup via RTC..that way any alarm or events you schedule would also wakeup the system if it has gone into sleep mode.
<br><br>Gopi<br></div><br>

------=_Part_65029_23487752.1175315586416--

--===============9084238246599099955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Devel mailing list
Devel@laptop.org
http://mailman.laptop.org/mailman/listinfo/devel

--===============9084238246599099955==--
