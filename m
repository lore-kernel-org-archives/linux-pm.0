From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Wed, 26 Apr 2006 12:24:43 +1000
Message-ID: <444ED9EB.5060205@yahoo.com.au>
References: <200604242355.08111.rjw@sisk.pl> <200604252312.26249.rjw@sisk.pl>
	<200604260718.42681.nigel@suspend2.net>
	<200604260021.08888.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70244291217441379=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604260021.08888.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============70244291217441379==
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Rafael J. Wysocki wrote:

>This means if we freeze bdevs, we'll be able to save all of the LRU pages,
>except for the pages mapped by the current task, without copying.  I think we
>can try to do this, but we'll need a patch to freeze bdevs for this purpose. ;-)
>

Why not the current task? Does it exit the kernel? Or go through some
get_uesr_pages path?

--

Send instant messages to your online friends http://au.messenger.yahoo.com 


--===============70244291217441379==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============70244291217441379==--
