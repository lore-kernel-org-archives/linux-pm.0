From: Mark Lord <lkml@rtr.ca>
Subject: Re: 2.6.14-rc4-mm1: USB suspend regression
Date: Wed, 19 Oct 2005 23:21:37 -0400
Message-ID: <43570D41.80505@rtr.ca>
References: <Pine.LNX.4.44L0.0510191156520.5049-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============24719444931646284=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0510191156520.5049-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============24719444931646284==
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan Stern wrote:
>
>>None of the recent kernels can resume-from-ram reliably for me
>>if I use CONFIG_USB_SUSPEND (set).   But with that option UNset,
>>suspend/resume to/from RAM works very well.
>
> Try applying this patch:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112966405019175&w=2

I have already adopted that patch independently,
and it has done wonders for stability with 2.6.14-rc4
coming back from suspend-to-ram.  Or is that just my imagination?

But I have not yet tried reenabling CONFIG_USB_SUSPEND in conjunction
with that patch -- just too much grief and wasted time every round
I try with CONFIG_USB_SUSPEND.  I'll get to it again eventually though.

Cheers

--===============24719444931646284==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============24719444931646284==--
