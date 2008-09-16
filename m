From: "Scott Thompson" <postfail@hushmail.com>
Subject: DSDT from your system / new DSDT archive
Date: Tue, 16 Sep 2008 12:55:42 -0400
Message-ID: <20080916165543.EA6A42003D@smtp.hushmail.com>
Reply-To: postfail@hushmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi all -- I was attempting to find a DSDT archive with sample DSDT 
from a variety of systems.
The closest thing I have found was the archive that was at 
http://acpi.sourceforge.net ; if anyone
knows of another DSDT archive please let me know.

Since a current one doesn't seem to exist, I am attempting to put 
my own database together up on the 
internets (URL coming soon) and am looking for folks to send me the 
DSDT from their systems.  Gathering your system DSDT takes
less than about 2 minutes by running the following:  

Windows:
1. extract acpica tools from acpica.org; latest as of this writing 
is http://acpica.org/download/iasl-win-20080829.zip
2. run 'iasl -g' to extract all acpi tables.
3. send all '.dsl' and '.dat' files extracted

Linux:
1. file is at /proc/acpi/dsdt 
2. may need to, as sudo or root, cp and then 'chown' the file to a 
non-root id to email.

If anyone is interested, please send the files (or url link), 
hardware make/model, and your name/email (if you want credited), to 
postfail@hushmail.com; please no bombardment of the linux-pm / 
linux-acpi lists.

Thanks in advance...

---------------------------------------
Scott Thompson / postfail@hushmail.com
---------------------------------------
