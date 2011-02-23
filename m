From: "Jan Beulich" <JBeulich@novell.com>
Subject: [Xen-devel] Re: [PATCH] xen: fix XEN_SAVE_RESTORE
	Kconfig	 dependencies
Date: Wed, 23 Feb 2011 10:58:57 +0000
Message-ID: <4D64F681020000780003347D@vpn.id2.novell.com>
References: <1298446066-11754-1-git-send-email-rshriram@cs.ubc.ca>
	<1298452123.16356.10537.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1298452123.16356.10537.camel@zakaz.uk.xensource.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shriram Rajagopalan <rshriram@cs.ubc.ca>, Ian Campbell <Ian.Campbell@eu.citrix.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: linux-pm@vger.kernel.org

>>> On 23.02.11 at 10:08, Ian Campbell <Ian.Campbell@eu.citrix.com> wrote:
> On Wed, 2011-02-23 at 07:27 +0000, Shriram Rajagopalan wrote:
>> Make XEN_SAVE_RESTORE user visible and enable HIBERNATION and SWAP,
>> if this option is enabled.
> 
> I was under the (perhaps mistaken?) impression that selecting user
> visible Kconfig symbols was verboten since it has side-effects which
> make it hard for users to figure out why something cannot be switched
> off and/or how to turn things on etc.
> 
> In any case I think I preferred the "depends HIBERNATION" idea -- I
> thought that was the consensus of the thread too?

Why HIBERNATION (and SWAP) instead of SUSPEND? Xen doesn't
support the former (other than the latter)...

Jan
