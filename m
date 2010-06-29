From: Nathaniel Felsen <nfelsen@gmail.com>
Subject: test acpi with acpi_fakekey and acpi_listen ... am I
	missing something ?
Date: Mon, 28 Jun 2010 19:33:32 -0700
Message-ID: <AANLkTinPUiVWLMLoQ8xroaNl9jnhHMlASBfAuMROEHgP@mail.gmail.com>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,
I'm trying to write an application that would execute a certain action
before the computers goes to sleep and after it wakes up.
I saw the man of apcid and that socket /var/run/acpid.socket (I'm
using ubuntu 10.4).
In my various test, I never get anything sent to that socket so I'd
like to test it independently from my application.
I saw the commands acpi_fakekey and acpi_listen
On 1 terminal I run:
sudo acpi_listen -c 1  (I know the sudo isn't really necessary
normally)

On another term I tried tones of command around
sudo acpi_fakekey KEY_VOLUMEUP

where I would change KEY_VOLUMEUP for some other value....

In my testing I never got anything in acpi_listen. It never quit, it
never printed anything....

Am I missing something or the acpi isn't working on my computer ???
Let me know if you have some suggestion on how to troubleshoot my issue

acpi_listen -v
acpid-1.0.10

Nat
