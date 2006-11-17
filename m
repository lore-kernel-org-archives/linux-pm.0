From: Mark Stosberg <mark@summersault.com>
Subject: Re: 2.6.19-rc <-> ThinkPads, (related Ubuntu bug report)
Date: Thu, 16 Nov 2006 20:53:40 -0500
Message-ID: <ejj4nl$d1n$1@sea.gmane.org>
References: <20061029231358.GI27968@stusta.de> <20061030135625.GB1601@mellanox.co.il> <20061101030126.GE27968@stusta.de> <20061104034906.GO13381@stusta.de>
Reply-To: linux-thinkpad@linux-thinkpad.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-thinkpad-admin@linux-thinkpad.org>
In-Reply-To: <20061104034906.GO13381@stusta.de>
Sender: linux-thinkpad-admin@linux-thinkpad.org
Errors-To: linux-thinkpad-admin@linux-thinkpad.org
List-Help: <mailto:linux-thinkpad-request@linux-thinkpad.org?subject=help>
List-Post: <mailto:linux-thinkpad@linux-thinkpad.org>
List-Subscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=subscribe>
List-Unsubscribe: <http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad>,
	<mailto:linux-thinkpad-request@linux-thinkpad.org?subject=unsubscribe>
List-Archive: <http://mailman.linux-thinkpad.org/pipermail/linux-thinkpad/>
To: linux-thinkpad@linux-thinkpad.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.osdl.org, discuss@x86-64.orglinux-kernel@vger.kernel.orglinux-acpi@vger.kernel.orglinux-pm@lists.osdl.orglinux-kernel@vger.kernel.orglinux-pm@lists.osdl.orgdiscuss@x86-64.org
List-Id: linux-pm@vger.kernel.org

Adrian Bunk wrote:
> As far as I can see, the 2.6.19-rc ThinkPad situation is still 
> confusing and we don't even know how many different bugs we are 
> chasing...

Hello,

I just hoped on this list to see what "ThinkPad" discussion there was.
Here my own observations:

Using Mandriva 2006 with 2.6.12, ACPI suspend/resume works great on a
ThinkPad T20. It didn't work with 2.6.14, and it doesn't work with
2.6.17 with Mandriva. Further, it doesn't seem to work with on some
ThinkPads with Ubuntu and 2.6.15 and 2.6.17 either, as this now-lengthy
bug report documents:

https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.17/+bug/50031

I added a comment there encouraging the other bug reporters to include
the kind of information requested on the ACPI website, but so far no have.

Personally, I'm still using 2.6.12 daily because of this regression.

I'm interested to help resolve it, but am not currently tracking the
latest kernel sources.

I realize this bug report is a bit out of date with respect to 2.6.19,
but as another poster suggested, this could simply indicate that at
least one regressions may not be recent.

   Mark

-- 
The linux-thinkpad mailing list home page is at:
http://mailman.linux-thinkpad.org/mailman/listinfo/linux-thinkpad
