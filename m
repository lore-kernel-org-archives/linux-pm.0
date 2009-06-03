From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [regression,
	bisected] adb trackpad disappears after suspend to ram
Date: Wed, 3 Jun 2009 22:20:19 +0200
Message-ID: <200906032220.19915.rjw@sisk.pl>
References: <878wkl6vce.fsf@scholz.fias.uni-frankfurt.de>
	<877hzty0hm.fsf@scholz.fias.uni-frankfurt.de>
	<200906032200.55563.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6188229504161222742=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906032200.55563.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Adrian Bunk <bunk@kernel.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Jan Scholz <scholz@fias.uni-frankfurt.de>
List-Id: linux-pm@vger.kernel.org

--===============6188229504161222742==
Content-Type: multipart/alternative;
  boundary="Boundary-00=_DstJKDv0Dyz4avr"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_DstJKDv0Dyz4avr
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit

On Wednesday 03 June 2009, Rafael J. Wysocki wrote:
[--snip--]
> 
> In that case I have no idea why it breaks.

Well, in fact I think there is an interrupt we shouldn't disable on suspend,
but we need to figure out which one it is.

Can you please send me /proc/interrupts from your system?

Rafael

--Boundary-00=_DstJKDv0Dyz4avr
Content-Type: text/html;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd"><html><head><meta name="qrichtext" content="1" /><style type="text/css">p, li { white-space: pre-wrap; }</style></head><body style=" font-family:'Sans Serif'; font-size:11pt; font-weight:400; font-style:normal;"><table style="-qt-table-type: root; margin-top:2px; margin-bottom:2px; margin-left:4px; margin-right:4px;"><tr><td style="border: none;">On Wednesday 03 June 2009, Rafael J. Wysocki wrote:<br>
[--snip--]<br>
&gt; <br>
&gt; In that case I have no idea why it breaks.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Well, in fact I think there is an interrupt we shouldn't disable on suspend,<br>
but we need to figure out which one it is.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Can you please send me /proc/interrupts from your system?<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Rafael<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p></td></tr></table></body></html>
--Boundary-00=_DstJKDv0Dyz4avr--

--===============6188229504161222742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6188229504161222742==--
